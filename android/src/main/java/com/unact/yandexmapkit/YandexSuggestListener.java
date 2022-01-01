package com.unact.yandexmapkit;

import androidx.annotation.NonNull;

import com.yandex.mapkit.search.SuggestItem;
import com.yandex.mapkit.search.SuggestSession;
import com.yandex.runtime.Error;
import com.yandex.runtime.network.NetworkError;
import com.yandex.runtime.network.RemoteError;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class YandexSuggestListener implements SuggestSession.SuggestListener {
  private final MethodChannel.Result result;

  public YandexSuggestListener(MethodChannel.Result result) {
    this.result = result;
  }

  @Override
  public void onResponse(@NonNull List<SuggestItem> suggestItems) {
    List<Map<String, Object>> suggests = new ArrayList<>();

    for (SuggestItem suggestItem : suggestItems) {
      Map<String, Object> suggestMap = new HashMap<>();

      suggestMap.put("title", suggestItem.getTitle().getText());
      if (suggestItem.getSubtitle() != null) {
        suggestMap.put("subtitle", suggestItem.getSubtitle().getText());
      }
      suggestMap.put("displayText", suggestItem.getDisplayText());
      suggestMap.put("searchText", suggestItem.getSearchText());
      suggestMap.put("type", suggestItem.getType().ordinal());
      suggestMap.put("tags", suggestItem.getTags());

      suggests.add(suggestMap);
    }

    Map<String, Object> arguments = new HashMap<>();
    arguments.put("items", suggests);
    result.success(arguments);
  }

  @Override
  public void onError(@NonNull Error error) {
    String errorMessage = "Unknown error";

    if (error instanceof NetworkError) {
      errorMessage = "Network error";
    }

    if (error instanceof RemoteError) {
      errorMessage = "Remote server error";
    }

    Map<String, Object> arguments = new HashMap<>();
    arguments.put("error", errorMessage);

    result.success(arguments);
  }
}
